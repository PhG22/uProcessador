LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
    PORT (
        clk : IN STD_LOGIC;
        address : IN unsigned (15 DOWNTO 0);
        data : OUT unsigned (15 DOWNTO 0)
    );
END rom;

ARCHITECTURE a_rom OF rom IS
    TYPE mem IS ARRAY (0 TO 255) OF unsigned (15 DOWNTO 0);
    CONSTANT content_rom : mem := (
        0 => B"0000_0000_0000_0000",
        1 => B"0001_001_0_00000011",
        2 => B"0001_000_1_00000010",
        3 => B"0011_0000_001_00000",
        4 => B"0100_0000_001_00000",
        5 => B"1100_0000_00001010",
        6 => B"0010_011_0_000_1_0000",
        7 => B"0111_0000_001_0_0000",
        8 => B"1111_0000_00001010",
        9 => B"0101_000_1_00000000",
        10 => B"1000_0000_001_0_0000",
        11 => B"1011_0000_11111110",
        12 => B"0110_010_0_001_0_0000",
        13 => B"1110_0000_11110011",

        OTHERS => (OTHERS => '0')
    );

BEGIN
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            data <= content_rom(to_integer(address));
        END IF;
    END PROCESS;
END a_rom;