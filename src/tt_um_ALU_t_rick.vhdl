library ieee;
use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;
-- use ieee.math_real.all;


entity tt_um_ALU_t_rick is
    port (
        clk   : in STD_LOGIC;
        rst_n : in STD_LOGIC;
        ena : in STD_LOGIC;
        ui_in : in STD_LOGIC_VECTOR(7 downto 0);
        uo_out : out STD_LOGIC_VECTOR(7 downto 0);
        uio_in : in STD_LOGIC_VECTOR(7 downto 0);
        uio_out : out STD_LOGIC_VECTOR(7 downto 0);
        uio_oe : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity tt_um_ALU_t_rick;

    
architecture rtl of tt_um_ALU_t_rick is
    signal portA : STD_LOGIC_VECTOR(3 downto 0);
    signal portB : STD_LOGIC_VECTOR(3 downto 0);
    signal portB_ones_complement : STD_LOGIC_VECTOR(3 downto 0);
    signal portA_ones_complement : STD_LOGIC_VECTOR(3 downto 0);
    signal fullAdder_sum : STD_LOGIC_VECTOR(3 downto 0);
    signal andOutput : STD_LOGIC_VECTOR(3 downto 0);
    signal orOutput : STD_LOGIC_VECTOR(3 downto 0);
    signal xorOutput : STD_LOGIC_VECTOR(3 downto 0);
    signal slOutputArithmetic : STD_LOGIC_VECTOR(3 downto 0);
    signal slOutputLogic : STD_LOGIC_VECTOR(3 downto 0);
    signal srOutputArithmetic : STD_LOGIC_VECTOR(3 downto 0);
    signal srOutputLogic : STD_LOGIC_VECTOR(3 downto 0);
    signal rlOutput : STD_LOGIC_VECTOR(3 downto 0);
    signal rrOutput : STD_LOGIC_VECTOR(3 downto 0);
    signal rltcOutput : STD_LOGIC_VECTOR(3 downto 0);
    signal rrtcOutput : STD_LOGIC_VECTOR(3 downto 0);
    signal muxOutput : STD_LOGIC_VECTOR(3 downto 0); --output of the multiplexer that goes to the output register
    signal carryintermediateAdd : STD_LOGIC;
    signal carryintermediateRL : STD_LOGIC;
    signal carryintermediateRR : STD_LOGIC;
    signal carryOut : STD_LOGIC;
    signal carryOut_saved : STD_LOGIC;
    signal zFlag : STD_LOGIC;
    signal nFlag : STD_LOGIC;
    signal vFlag : STD_LOGIC;
begin

    uio_oe <= (others => '0'); --set all bidirectional ios to inputs
    uio_out(7) <= ena;
    uio_out(6 downto 3) <= (others => '0'); --set all outputs of the bidirectional pins to zero so they're not optimized away
    uio_out(2 downto 0) <= uio_in(7 downto 5);

    inputRegister : process (clk, rst_n)
    begin
        if (rst_n = '0') then
            portA <= (others => '0');
            portB <= (others => '0');
        elsif (rising_edge(clk)) then
            portA <= ui_in(3 downto 0);
            portB <= ui_in(7 downto 4);
        end if;
    end process;

    process (portB)
    begin
        portB_ones_complement(0) <= portB(0) xor uio_in(0);
        portB_ones_complement(1) <= portB(1) xor uio_in(0);
        portB_ones_complement(2) <= portB(2) xor uio_in(0);
        portB_ones_complement(3) <= portB(3) xor uio_in(0);
    end process;

    fullAdder4bit : entity work.fullAdder_4bit(rtl)
        port map (
            summand1_4bit => portA,
            summand2_4bit => portB_ones_complement,
            carryIn_4bit => uio_in(0),
            carryOut_4bit => carryintermediateAdd,
            sum_4bit => fullAdder_sum
        );

    andOup : process (portA, portB)
    begin
        andOutput <= portA and portB;
    end process;

    orOup : process (portA, portB)
    begin
        orOutput <= portA or portB;
    end process;

    xorOup : process (portA, portB)
    begin
        xorOutput <= portA xor portB;
    end process;

    onescomplOup : process (portA, portB)
    begin
        portA_ones_complement <= not portA;
    end process;

    shiftLeftArithmetic : process (portA)
    begin
        slOutputArithmetic(3) <= portA(3);
        slOutputArithmetic(2 downto 1) <= portA(1 downto 0);
        slOutputArithmetic(0) <= '0';
    end process;

    shiftLeftLogic : process (portA)
    begin
        slOutputLogic(3 downto 1) <= portA(2 downto 0);
        slOutputLogic(0) <= '0';
    end process;

    shiftRightA : process (portA) --rightshift with sign extend
    begin
            -- srOutput <= (3 => ui_in(3), ui_in(3 downto 1));
            srOutputArithmetic(2 downto 0) <= portA(3 downto 1);
            srOutputArithmetic(3) <= portA(3);
    end process;

    shiftRightL : process (portA) --rightshift with sign extend
    begin
            -- srOutput <= (3 => ui_in(3), ui_in(3 downto 1));
            srOutputLogic(2 downto 0) <= portA(3 downto 1);
            srOutputLogic(3) <= '0';
    end process;

    rotateLeft : process (portA)
    begin
        -- rlOutput <= (ui_in(2 downto 0), 0 => ui_in(3));
        rlOutput(3 downto 1) <= portA(2 downto 0);
        rlOutput(0) <= portA(3);
    end process;

    rotateRight : process (portA)
    begin
        -- rrOutput <= (3 => ui_in(0), ui_in(3 downto 1));
        rrOutput(2 downto 0) <= portA(3 downto 1);
        rrOutput(3) <= portA(0);
    end process;

    rotateLeftThroughCarry : process (portA, carryOut, carryintermediateRL)
    begin
        -- rltcOutput <= (ui_in(2 downto 0), 0 => carryOut);
        rltcOutput(3 downto 1) <= portA(2 downto 0);
        rltcOutput(0) <= carryOut_saved;
        carryintermediateRL <= portA(3);
    end process;

    rotateRightThroughCarry : process (portA, carryOut, carryintermediateRR)
    begin
        -- rrtcOutput <= (3 => carryOut, ui_in(3 downto 1));
        rrtcOutput(2 downto 0) <= portA(3 downto 1);
        rrtcOutput(3) <= carryOut_saved;
        carryintermediateRR <= portA(0);
    end process;

    outputMux : process (uio_in, fullAdder_sum, andOutput, orOutput, xorOutput, slOutputArithmetic, srOutputArithmetic, rlOutput, rrOutput, muxOutput)
    begin
        case uio_in(4 downto 1) is
            when "0000" =>
                muxOutput <= fullAdder_sum;
                carryOut <= carryintermediateAdd;
            when "0001" =>
                muxOutput <= andOutput;
                carryOut <= '0';
            when "0010" =>
                muxOutput <= orOutput;
                carryOut <= '0';
            when "0011" =>
                muxOutput <= xorOutput;
                carryOut <= '0';
            when "0100" =>
                muxOutput <= portA_ones_complement;
                carryOut <= '0';
            when "0101" =>
                muxOutput <= slOutputArithmetic;
                carryOut <= '0';
            when "0110" =>
                muxOutput <= slOutputLogic;
                carryOut <= '0';
            when "0111" =>
                muxOutput <= srOutputArithmetic;
                carryOut <= '0';
            when "1000" =>
                muxOutput <= srOutputLogic;
                carryOut <= '0';
            when "1001" =>
                muxOutput <= rlOutput;
                carryOut <= '0';
            when "1010" =>
                muxOutput <= rrOutput;
                carryOut <= '0';
            when "1011" =>
                muxOutput <= rltcOutput;
                carryOut <= carryintermediateRL;
            when "1100" =>
                muxOutput <= rrtcOutput;
                carryOut <= carryintermediateRR;
            when others =>
                muxOutput <= fullAdder_sum;
                carryOut <= carryintermediateAdd;
        end case;
    end process;

    flagsProc : process (fullAdder_sum, portA, portB, carryOut, uio_in)
    begin
        zFlag <= not (fullAdder_sum(3) or fullAdder_sum(2) or fullAdder_sum(1) or fullAdder_sum(0));
        nFlag <= fullAdder_sum(3);
        vFlag <= (((not portA(3) and not portB(3) and fullAdder_sum(3)) or (portA(3) and portB(3) and not fullAdder_sum(3))) and not uio_in(0)) or (((not portA(3) and portB(3) and fullAdder_sum(3)) or (portA(3) and not portB(3) and not fullAdder_sum(3))) and uio_in(0));
        -- carryOut <= carryintermediateAdd or carryintermediateRL or carryintermediateRR;
    end process;

    outputRegister : process (clk, rst_n)
    begin
        if (rst_n = '0') then
            uo_out <= (others => '0');
            carryOut_saved <= '0';
        elsif (rising_edge(clk)) then
            -- ou_out <= (7 => vFlag, 6 => nFlag, 5 => zFlag, 4 => carryOut, muxOutput);
            uo_out(3 downto 0) <= muxOutput;
            uo_out(4) <= carryOut;
            uo_out(5) <= zFlag;
            uo_out(6) <= nFlag;
            uo_out(7) <= vFlag;
            carryOut_saved <= carryOut;
        end if;
    end process;

end architecture;