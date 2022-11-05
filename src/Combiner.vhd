----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:59:35 11/27/2018 
-- Design Name: 
-- Module Name:    Combiner - Behavioral 
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

entity Combiner is
	Port (  CombSensorOutput : in  STD_LOGIC;
			  CombTrigOut : out STD_LOGIC;
			  CombBuzzerOut : out STD_LOGIC;
           CombClk : in STD_LOGIC;
			  CombDistance : out  STD_LOGIC_VECTOR (8 downto 0));
end Combiner;

architecture Structural of Combiner is

Signal A : STD_LOGIC_VECTOR (8 downto 0);
Signal B : STD_LOGIC;
Signal C : STD_LOGIC;

COMPONENT Distance_Calc
Port ( SensorOutput1 : in  STD_LOGIC;
       Clk1 : in STD_LOGIC;
       Distance1 : out  STD_LOGIC_VECTOR (8 downto 0));
END COMPONENT ;


COMPONENT Trigger
Port ( SensorOutput2 : in  STD_LOGIC;
       Clk2 : in STD_LOGIC;
       TriggerOutput : out  STD_LOGIC);
END COMPONENT ;


COMPONENT Buzzer
Port ( BuzzerOut : out STD_LOGIC;
		 Clk3 : in STD_LOGIC;
		 Distance2 : in  STD_LOGIC_VECTOR (8 downto 0));
END COMPONENT ;


begin

U1: Distance_Calc port map (Distance1 => A,
SensorOutput1 => CombSensorOutput,
Clk1 => CombClk);

U2: Trigger port map (TriggerOutput => B,
SensorOutput2 => CombSensorOutput,
Clk2 => CombClk);

U3: Buzzer port map (BuzzerOut => C,
Distance2 => A,
Clk3 => CombClk);

CombDistance <= A;
CombTrigOut <= B;
CombBuzzerOut <= C;


end structural;


