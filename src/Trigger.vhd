----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:40 11/20/2018 
-- Design Name: 
-- Module Name:    Trigger - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Trigger is
    Port ( SensorOutput2 : in  STD_LOGIC;
	 	     Clk2 : in STD_LOGIC;
           TriggerOutput : out  STD_LOGIC);
end Trigger;

architecture Behavioral of Trigger is


begin


process(Clk2)
variable counter1 : STD_LOGIC_VECTOR (10 downto 0); --variable for 10us counter
variable counter2 : STD_LOGIC_VECTOR (25 downto 0); --variable for measurement period
begin

if(rising_edge(Clk2)) then --if statement triggers with the rising edge of the clock
if (SensorOutput2 = '0') then --when the sensor output is 0 we start counting for measurement period
 counter2 := counter2 + '1';
 if (counter2 >= "01011111010111100001000000") then --our measurement period is 250ms+10us
	if (counter1 <= "01111101000") then --when we reach 250ms we start sending the trigger signal to our sensor
		counter1 := counter1 + '1';
		TriggerOutput <= '1';
	else 
		counter1 := "00000000000"; --after we send our trigger signal we reset both counters and trigger signal
		counter2 := "00000000000000000000000000";
		TriggerOutput <= '0';
	end if;
 end if;
 

 else --we don't trigger our sensor if its already measuring something (when it is 1)
 counter1 := "00000000000";
 counter2 := "00000000000000000000000000";
 TriggerOutput <= '0';
end if;
end if; 
 
end process;

end Behavioral;

