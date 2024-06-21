LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity registrador is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           write_enable : in STD_LOGIC;
           write_data : in UNSIGNED(15 downto 0);
           read_data : out UNSIGNED(15 downto 0));
end registrador;

architecture a_registrador of registrador is
    signal reg_data : unsigned(15 downto 0) := (others => '0'); -- Registrador com valor inicial = 0
begin
    process(clk, rst, write_enable)
    begin
        if rst = '1' then
            reg_data <= (others => '0');-- Zera o registrador
        elsif write_enable = '1' then              
            if rising_edge(clk) then
                reg_data <= write_data;
            end if;
        end if;
    end process;
    read_data <= reg_data;
end a_registrador;