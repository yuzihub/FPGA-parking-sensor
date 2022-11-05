----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:01:13 11/20/2018 
-- Design Name: 
-- Module Name:    Distance_Calc - Behavioral 
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

entity Distance_Calc is
    Port ( SensorOutput1 : in  STD_LOGIC;
	        Clk1 : in STD_LOGIC;
           Distance1 : out  STD_LOGIC_VECTOR (8 downto 0));
end Distance_Calc;

architecture Behavioral of Distance_Calc is

signal counterTemp : STD_LOGIC_VECTOR (24 downto 0);
signal counterTemp1 : STD_LOGIC_VECTOR (24 downto 0);

signal cm90 : STD_LOGIC_VECTOR (24 downto 0);
signal cm80 : STD_LOGIC_VECTOR (24 downto 0);
signal cm70 : STD_LOGIC_VECTOR (24 downto 0);
signal cm60 : STD_LOGIC_VECTOR (24 downto 0);
signal cm50 : STD_LOGIC_VECTOR (24 downto 0);
signal cm40 : STD_LOGIC_VECTOR (24 downto 0);
signal cm30 : STD_LOGIC_VECTOR (24 downto 0);
signal cm20 : STD_LOGIC_VECTOR (24 downto 0);
signal cm10 : STD_LOGIC_VECTOR (24 downto 0);



begin

-- binary numbers representing times corresponding to distance of the object

--m4 <= "0001000111001011011001001";
cm90 <= "0000010000000000111101101";
cm80 <= "0000001110001111000101000";
cm70 <= "0000001100011101001100011";
cm60 <= "0000001010101011010011110";
cm50 <= "0000001000111001011011001";
cm40 <= "0000000111000111100010100";
cm30 <= "0000000101010101101001111";
cm20 <= "0000000011100011110001010";
cm10 <= "0000000001110001111000101";


process(Clk1)
variable counter1 : STD_LOGIC_VECTOR (24 downto 0);
begin
if (rising_edge(Clk1)) then --if triggers with each rising edge of the clock
	if (SensorOutput1 = '1') then --we start counting time when sensor outputs 1
		counter1 := counter1 + '1';
		
	else
		counterTemp1 <= counter1;	--we assign the value of time to another variable
		if (counterTemp1 > "0000000000000000000000000") then
			counterTemp <= CounterTemp1; --we store the value of time in a latch until we read data from sensor again
		end if;	
   	counter1 := "0000000000000000000000000"; --we reset our counter after the sensor output is 0
		
		
	end if;
end if;
end process;



Distance1 <= "000000000" when counterTemp>=cm90 else --we compare the time values and determine distance
			   "000000001" when counterTemp<=cm90 and counterTemp>cm80 else
			   "000000011" when counterTemp<=cm80 and counterTemp>cm70 else
			   "000000111" when counterTemp<=cm70 and counterTemp>cm60 else
			   "000001111" when counterTemp<=cm60 and counterTemp>cm50 else
			   "000011111" when counterTemp<=cm50 and counterTemp>cm40 else
			   "000111111" when counterTemp<=cm40 and counterTemp>cm30 else
			   "001111111" when counterTemp<=cm30 and counterTemp>cm20 else
			   "011111111" when counterTemp<=cm20 and counterTemp>cm10 else
			   "111111111" when counterTemp<=cm10 else
				"000000000";


end Behavioral;

