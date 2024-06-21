LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY banco_registradores_tb IS
END ENTITY banco_registradores_tb;

ARCHITECTURE a_banco_registradores_tb OF banco_registradores_tb IS

    COMPONENT banco_registradores
        PORT (
            sel_reg : IN unsigned (2 DOWNTO 0);
            sel_reg_write : IN unsigned (2 DOWNTO 0);
            write_data : IN unsigned (15 DOWNTO 0);
            write_enable, clk, rst : IN STD_LOGIC;
            reg_data : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';
    SIGNAL sel_reg_sig : unsigned (2 DOWNTO 0);
    SIGNAL sel_reg_write_sig : unsigned (2 DOWNTO 0);
    SIGNAL write_data : unsigned (15 DOWNTO 0);
    SIGNAL write_enable : STD_LOGIC;
    SIGNAL reg_data_sig : unsigned (15 DOWNTO 0);

BEGIN

    uut_banco_registradores_tb : banco_registradores
    PORT MAP(
        sel_reg => sel_reg_sig,
        sel_reg_write => sel_reg_write_sig,
        write_data => write_data,
        write_enable => write_enable,
        clk => clk,
        rst => rst,
        reg_data => reg_data_sig
    );

    -- Geração de clock
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

    -- Reset
    reset_process : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 20 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    -- Teste de leitura e escrita
    test_process : PROCESS
    BEGIN
        -- Initialize
        sel_reg_sig <= (others => '0');
        sel_reg_write_sig <= (others => '0');
        write_data <= (others => '0');
        write_enable <= '0';
 
        WAIT FOR 40 ns;

        -- Teste de escrita reg 1
        sel_reg_sig <= "000";
        sel_reg_write_sig <= "001";
        write_enable <= '1';
        write_data <= x"1234";
        WAIT FOR 20 ns;

        -- Teste de escrita reg 2
        sel_reg_sig <= "001";
        sel_reg_write_sig <= "010";
        write_enable <= '1';
        write_data <= x"4567";
        WAIT FOR 20 ns;

        -- Teste de escrita reg3
        sel_reg_sig <= "010";
        sel_reg_write_sig <= "011";
        write_enable <= '1';
        write_data <= x"ABCD";
        WAIT FOR 20 ns;

        -- Teste de escrita reg 4
        sel_reg_sig <= "011";
        sel_reg_write_sig <= "100";
        write_enable <= '1';
        write_data <= x"ac12";
        WAIT FOR 20 ns;

        -- Teste de escrita reg 5
        sel_reg_sig <= "100";
        sel_reg_write_sig <= "101";
        write_enable <= '1';
        write_data <= x"5677";
        WAIT FOR 20 ns;

        -- Teste de escrita reg 6
        sel_reg_sig <= "101";
        sel_reg_write_sig <= "110";
        write_enable <= '1';
        write_data <= x"d456";
        WAIT FOR 20 ns;

        -- Teste de escrita reg 7
        sel_reg_sig <= "110";
        sel_reg_write_sig <= "111";
        write_enable <= '1';
        write_data <= x"FFFF";
        WAIT FOR 20 ns;

        -- Teste de escrita wr_en = 0
        sel_reg_sig <= "111";
        sel_reg_write_sig <= "111";
        write_enable <= '0';
        write_data <= x"FFFE";
        WAIT FOR 20 ns;

        WAIT;
    END PROCESS;
END a_banco_registradores_tb;