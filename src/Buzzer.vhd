----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:59:23 11/27/2018 
-- Design Name: 
-- Module Name:    Buzzer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
  use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Buzzer is
	Port ( BuzzerOut : out STD_LOGIC;
		    Clk3 : in STD_LOGIC;
			 Distance2 : in  STD_LOGIC_VECTOR (8 downto 0));
end Buzzer;

architecture Behavioral of Buzzer is

signal BuzzerCount: STD_LOGIC_VECTOR (3 downto 0);
signal Sound: STD_LOGIC_VECTOR (26 downto 0);




begin

Sound <= "000100110001001011010000000"; --1/10th of a second is stored in a variable


process (Clk3)
variable clk1: STD_LOGIC_VECTOR (26 downto 0);
begin
case Distance2 is --we determine a coefficient in regards to our measured distance
 
 when "000000001" =>
 BuzzerCount <= "0001";
 
 when "000000011" =>
 BuzzerCount <= "0010";
 
 when "000000111" =>
 BuzzerCount <= "0011";
 
 when "000001111" =>
 BuzzerCount <= "0100";
 
 when "000011111" =>
 BuzzerCount <= "0101";
 
 when "000111111" =>
 BuzzerCount <= "0110";
 
 when "001111111" =>
 BuzzerCount <= "0111";
 
 when "011111111" =>
 BuzzerCount <= "1000";
 
 when "111111111" =>
 BuzzerCount <= "1001";


 when others =>
 BuzzerCount <= "0000";

 end case;

if (rising_edge(Clk3)) then --if statement triggers with each rising edge of the clock
 if (BuzzerCount > "0000") then --when our buzzer coeff. is greater than 0000 we start counting
	clk1 := clk1+1;
		if (clk1 <= Sound) then --our buzzer will create sound as long as our "Sound" coefficient
			BuzzerOut <= '1';
		else
			BuzzerOut <= '0';
		end if;
	   if (clk1 > Sound*("1010" - BuzzerCount)) then --buzzer will stay silent as long as the value of "Sound*("1010" - BuzzerCount)"
			clk1 := "000000000000000000000000000";
      end if;
 else
 BuzzerOut <= '0'; --buzzer stays silent if our sensor cannot measure the distance
 end if;
end if; 
end process;

end Behavioral;

