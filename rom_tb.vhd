LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom_tb IS
END rom_tb;

ARCHITECTURE a_rom_tb OF rom_tb IS

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL address : UNSIGNED(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data : UNSIGNED(15 DOWNTO 0);

    COMPONENT rom
        PORT (
            clk : IN STD_LOGIC;
            address : IN UNSIGNED(15 DOWNTO 0);
            data : OUT UNSIGNED(15 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    uut : rom
    PORT MAP (
        clk => clk,
        address => address,
        data => data
    );

    clk_process : PROCESS
    BEGIN
        WHILE now < 1000 ns LOOP
            clk <= '0';
            WAIT FOR 10 ns;
            clk <= '1';
            WAIT FOR 10 ns;
        END LOOP;
        WAIT;
    END PROCESS;

    test_process : PROCESS
    BEGIN

        address <= (OTHERS => '0');

        -- Teste 1: endereço 0
        address <= "0000000000000000";
        WAIT FOR 40 ns;

        -- Teste 2: endereço 1
        address <= "0000000000000001";
        WAIT FOR 40 ns;

        -- Teste 3: endereço 2
        address <= "0000000000000010";
        WAIT FOR 40 ns;

        -- Teste 3: endereço 3
        address <= "0000000000000011";
        WAIT FOR 40 ns;

        -- Teste 3: endereço 4
        address <= "0000000000000100";
        WAIT FOR 40 ns;
        
        -- Teste 3: endereço 5
        address <= "0000000000000101";
        WAIT FOR 40 ns;

        -- Teste 3: endereço 6
        address <= "0000000000000110";
        WAIT FOR 40 ns;

        -- Teste 3: endereço 7
        address <= "0000000000000111";
        WAIT FOR 40 ns;

        -- Teste 3: endereço 8
        address <= "0000000000001000";
        WAIT FOR 40 ns;

        -- Teste 3: endereço 9
        address <= "0000000000001001";
        WAIT FOR 40 ns;

        -- Teste 3: endereço 9
        address <= "0000000000001010";
        WAIT FOR 40 ns;

        -- Teste 4: endereço 255
        address <=  "0000000011111111";
        WAIT FOR 40 ns;

        WAIT;
    END PROCESS;

END a_rom_tb;
