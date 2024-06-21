LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ram_tb IS
END ENTITY;

ARCHITECTURE tb_arch OF ram_tb IS
    COMPONENT ram
        PORT (
            clk : IN STD_LOGIC;
            address : IN unsigned(15 DOWNTO 0);
            wr_en : IN STD_LOGIC;
            data_in : IN unsigned(15 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL address : unsigned(15 DOWNTO 0) := (others => '0');
    SIGNAL wr_en : STD_LOGIC := '0';
    SIGNAL data_in : unsigned(15 DOWNTO 0) := (others => '0');
    SIGNAL data_out : unsigned(15 DOWNTO 0);
    
BEGIN
    uut: ram
    PORT MAP (
        clk => clk,
        address => address,
        wr_en => wr_en,
        data_in => data_in,
        data_out => data_out
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
    
    test : PROCESS
    BEGIN        
        WAIT FOR 10 ns;
        
        -- Write to RAM
        address <= x"0000";
        wr_en <= '1';
        data_in <= x"0001";
        WAIT FOR 10 ns;
        
        -- Read from RAM
        address <= x"0000";
        wr_en <= '0';
        WAIT FOR 10 ns;
        
        -- Write to RAM
        address <= x"0001";
        wr_en <= '1';
        data_in <= x"000A";
        WAIT FOR 10 ns;
        
        -- Read from RAM
        address <= x"0001";
        wr_en <= '0';
        WAIT FOR 10 ns;
        
        WAIT;
    END PROCESS;
    
END ARCHITECTURE;
