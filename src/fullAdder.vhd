library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
    port (
        carryIn : in STD_ULOGIC;
        summand1 : in STD_ULOGIC;
        summand2 : in STD_ULOGIC;
        carryOut : out STD_ULOGIC;
        sum : out STD_ULOGIC
    );
end entity fullAdder;

architecture rtl of fullAdder is
    signal halfAdder_carry : STD_ULOGIC;
    signal halfAdder_sum : STD_ULOGIC;
    signal halfAdder_carryIntermediate : STD_ULOGIC;
begin
    halfAdder_carry <= summand1 and summand2;
    halfAdder_sum <= summand1 xor summand2;
    sum <= halfAdder_sum xor carryIn;
    halfAdder_carryIntermediate <= halfAdder_sum and carryIn;
    carryOut <= halfAdder_carryIntermediate or halfAdder_carry;
    -- sum <= carryIn xor summand1 xor summand2;
    -- carryOut <= (carryIn and summand1) or (summand2 and summand1);

end architecture;
