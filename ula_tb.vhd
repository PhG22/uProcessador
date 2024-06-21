-- Pedro Henrique Guimarães Gomes - 2193000

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_tb IS
END ula_tb;

ARCHITECTURE a_ula_tb OF ula_tb IS
    COMPONENT ula
        PORT (
            in_A : IN unsigned(15 DOWNTO 0);
            in_B : IN unsigned(15 DOWNTO 0);
            op : IN unsigned(1 DOWNTO 0);
            result : OUT unsigned(15 DOWNTO 0);
            zero, negative: OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL data_A, data_B : unsigned(15 DOWNTO 0);
    SIGNAL operation : unsigned(1 DOWNTO 0);
    SIGNAL result : unsigned(15 DOWNTO 0);
    SIGNAL zero, negative : STD_LOGIC;

BEGIN
    uut : ula
    PORT MAP(
        in_A => data_A,
        in_B => data_B,
        op => operation,
        result => result,
        zero => zero,
        negative => negative
    );

    PROCESS
    BEGIN
        -- Adição
        operation <= "00";
        -- 2 + 3 = 5
        data_A <= "0000000000000010";
        data_B <= "0000000000000011";
        WAIT FOR 10 ns;

        -- 0 + (-2) = -2
        data_A <= "0000000000000000";
        data_B <= "1111111111111110";
        WAIT FOR 10 ns;

        -- 2 + (-2) = 0
        data_A <= "0000000000000010";
        data_B <= "1111111111111110";
        WAIT FOR 10 ns;

        -- (-2) + 4 = 2
        data_A <= "1111111111111110";
        data_B <= "0000000000000100";
        WAIT FOR 10 ns;

        -- Subtração
        operation <= "01";
        
        -- 2 - 1 = 1
        data_A <= "0000000000000010";
        data_B <= "0000000000000001";
        WAIT FOR 10 ns;
        
        -- 4 - (-2) = 6
        data_A <= "0000000000000100";
        data_B <= "1111111111111110"; 
        WAIT FOR 10 ns;
        
        -- 1 - 4 = -3
        data_A <= "0000000000000001";
        data_B <= "0000000000000100";
        WAIT FOR 10 ns;
        
        -- -1 - 4 = -5
        data_A <= "1111111111111111";
        data_B <= "0000000000000100";
        WAIT FOR 10 ns;

        -- Igual
        operation <= "10";

        -- 0 = 0 -> 1
        data_A <= "0000000000000000";
        data_B <= "0000000000000000";
        WAIT FOR 10 ns;

        -- 0 = 1 -> 0
        data_A <= "0000000000000000";
        data_B <= "0000000000000001";
        WAIT FOR 10 ns;

        -- Multiplicação
        operation <= "11";

        -- 4 * 3 = 12
        data_A <= "0000000000000100";
        data_B <= "0000000000000011";
        WAIT FOR 10 ns;

        -- (-2) * 4 = -8
        data_A <= "1111111111111111";
        data_B <= "0000000000000100";
        WAIT FOR 10 ns;

        -- 0 * 4 = 0
        data_A <= "0000000000000000";
        data_B <= "0000000000000100";
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END a_ula_tb;