LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY banco_registradores IS
    PORT (
        sel_reg : IN unsigned (2 DOWNTO 0);
        sel_reg_write : IN unsigned (2 DOWNTO 0);
        write_data : IN unsigned (15 DOWNTO 0);
        write_enable, clk, rst : IN STD_LOGIC;
        reg_data : OUT unsigned (15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_banco_registradores OF banco_registradores IS
    COMPONENT registrador IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            write_enable : IN STD_LOGIC;
            write_data : IN UNSIGNED(15 DOWNTO 0);
            read_data : OUT UNSIGNED(15 DOWNTO 0));
    END COMPONENT;

    SIGNAL read_data_0, read_data_1, read_data_2, read_data_3, read_data_4, read_data_5, read_data_6, read_data_7 : unsigned (15 DOWNTO 0);
    SIGNAL write_enable_1, write_enable_2, write_enable_3, write_enable_4, write_enable_5, write_enable_6, write_enable_7 : STD_LOGIC;

BEGIN
    reg0 : registrador PORT MAP(clk => clk, rst => rst, write_enable => '0', write_data => (OTHERS => '0'), read_data => read_data_0);
    reg1 : registrador PORT MAP(clk => clk, rst => rst, write_enable => write_enable_1, write_data => write_data, read_data => read_data_1);
    reg2 : registrador PORT MAP(clk => clk, rst => rst, write_enable => write_enable_2, write_data => write_data, read_data => read_data_2);
    reg3 : registrador PORT MAP(clk => clk, rst => rst, write_enable => write_enable_3, write_data => write_data, read_data => read_data_3);
    reg4 : registrador PORT MAP(clk => clk, rst => rst, write_enable => write_enable_4, write_data => write_data, read_data => read_data_4);
    reg5 : registrador PORT MAP(clk => clk, rst => rst, write_enable => write_enable_5, write_data => write_data, read_data => read_data_5);
    reg6 : registrador PORT MAP(clk => clk, rst => rst, write_enable => write_enable_6, write_data => write_data, read_data => read_data_6);
    reg7 : registrador PORT MAP(clk => clk, rst => rst, write_enable => write_enable_7, write_data => write_data, read_data => read_data_7);

    reg_data <=   read_data_0 WHEN sel_reg = "000" ELSE
                    read_data_1 WHEN sel_reg = "001" ELSE
                    read_data_2 WHEN sel_reg = "010" ELSE
                    read_data_3 WHEN sel_reg = "011" ELSE
                    read_data_4 WHEN sel_reg = "100" ELSE
                    read_data_5 WHEN sel_reg = "101" ELSE
                    read_data_6 WHEN sel_reg = "110" ELSE
                    read_data_7 WHEN sel_reg = "111" ELSE
                    "0000000000000000";

    write_enable_1 <= write_enable WHEN sel_reg_write = "001" ELSE
        '0';
    write_enable_2 <= write_enable WHEN sel_reg_write = "010" ELSE
        '0';
    write_enable_3 <= write_enable WHEN sel_reg_write = "011" ELSE
        '0';
    write_enable_4 <= write_enable WHEN sel_reg_write = "100" ELSE
        '0';
    write_enable_5 <= write_enable WHEN sel_reg_write = "101" ELSE
        '0';
    write_enable_6 <= write_enable WHEN sel_reg_write = "110" ELSE
        '0';
    write_enable_7 <= write_enable WHEN sel_reg_write = "111" ELSE
        '0';
END a_banco_registradores;