----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2026 08:41:27
-- Design Name: 
-- Module Name: PWM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM is
    Port (
        reset : in std_logic;
        clk : in std_logic;
        t_on : in std_logic_vector(8-1 DOWNTO 0); -- UNSIGNED
        t_total : in std_logic_vector(8-1 DOWNTO 0); -- UNSIGNED
        pwm_out : out std_logic
    );
end PWM;

architecture Behavioral of PWM is

    signal sig_out : std_logic;
        
begin

    process (clk, reset, sig_out)
    variable count : integer := 0;
    variable old_pwm : std_logic;
    begin
        if reset = '1' then
           count := 0;
           old_pwm := '0';
           sig_out <= '0';
        elsif rising_edge(clk) then
            if count <= to_integer(unsigned(t_on))+1 then
                sig_out <= '1';
                old_pwm := '1';
            elsif count > to_integer(unsigned(t_on))+1 then
                sig_out <= '0';
                old_pwm := '0';
            end if;
            
            if count = to_integer(unsigned(t_total))+1 then
                sig_out <= old_pwm;
                count := 0;
            end if;
            count := count +1;
        end if;
        
end process;

    pwm_out <= sig_out;

end Behavioral;
