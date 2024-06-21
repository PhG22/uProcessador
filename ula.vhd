-- Pedro Henrique Guimarães Gomes - 2193000

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
    PORT (
        in_A : IN unsigned(15 DOWNTO 0);
        in_B : IN unsigned(15 DOWNTO 0);
        op : IN unsigned(1 DOWNTO 0);
        result : OUT unsigned(15 DOWNTO 0);
        zero, negative : OUT STD_LOGIC
    );
END ula;

ARCHITECTURE a_ula OF ula IS
    SIGNAL aux : unsigned(15 DOWNTO 0);
    SIGNAL mult : unsigned(31 DOWNTO 0);
BEGIN
    mult <= in_A * in_B WHEN op = "11";
    aux <= in_A + in_B WHEN op = "00" ELSE
            in_B - in_A WHEN op = "01" ELSE
            "0000000000000001"    WHEN op = "10" AND in_A = in_B ELSE
            mult(15 DOWNTO 0) WHEN op = "11" ELSE
            "0000000000000000";

    zero <= '1' WHEN aux(15 DOWNTO 0) = 0 ELSE
        '0';

    negative <= aux(15);
    result <= aux(15 DOWNTO 0);
END a_ula;

-- operação  sel_op
--   A+B       00
--   B-A       01
--   A=B       10
--   A*B       11