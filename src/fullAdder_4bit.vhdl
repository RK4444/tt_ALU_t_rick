library ieee;
use ieee.std_logic_1164.all;

entity fullAdder_4bit is
    port (
        carryIn_4bit : in STD_ULOGIC;
        summand1_4bit : in STD_ULOGIC_VECTOR(3 downto 0);
        summand2_4bit : in STD_ULOGIC_VECTOR(3 downto 0);
        carryOut_4bit : out STD_ULOGIC;
        sum_4bit : out STD_ULOGIC_VECTOR(3 downto 0)
        
    );
end entity fullAdder_4bit;

architecture rtl of fullAdder_4bit is
    signal carry0 : STD_ULOGIC;
    signal carry1 : STD_ULOGIC;
    signal carry2 : STD_ULOGIC;
begin

    c0 : entity work.fullAdder(rtl)
        port map(
            carryIn => carryIn_4bit,
            summand1 => summand1_4bit(0),
            summand2 => summand2_4bit(0),
            carryOut => carry0,
            sum => sum_4bit(0)
        );

    c1 : entity work.fullAdder(rtl)
        port map(
            carryIn => carry0,
            summand1 => summand1_4bit(1),
            summand2 => summand2_4bit(1),
            carryOut => carry1,
            sum => sum_4bit(1)
        );

    c2 : entity work.fullAdder(rtl)
        port map(
            carryIn => carry1,
            summand1 => summand1_4bit(2),
            summand2 => summand2_4bit(2),
            carryOut => carry2,
            sum => sum_4bit(2)
        );

    c3 : entity work.fullAdder(rtl)
        port map(
            carryIn => carry2,
            summand1 => summand1_4bit(3),
            summand2 => summand2_4bit(3),
            carryOut => carryOut_4bit,
            sum => sum_4bit(3)
        );

end architecture;