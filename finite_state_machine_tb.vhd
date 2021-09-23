library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity finite_state_machine_tb is
end entity;

architecture sim of finite_state_machine_tb is

    -- We're slowing down the clock to speed up simulation time
    constant ClockFrequencyHz : integer := 100; -- 100 Hz
    constant ClockPeriod      : time    := 1000 ms / ClockFrequencyHz;

    -- Declare signals
    signal i_Clk_t  : std_logic := '1';
    signal i_nRst_t : std_logic := '0';

    -- Associating the description to be tested
    component finite_state_machine
        generic(ClockFrequencyHz: integer);
        port(
            i_Clk  : in std_logic;
            i_nRst : in std_logic   -- Negative reset
        );
    end component;
begin

    -- The Unit Under Test (UUT)
    UUT: finite_state_machine
    generic map(ClockFrequencyHz => ClockFrequencyHz)
    port map (
        i_Clk => i_Clk_t,
        i_nRst => i_nRst_t
    );

    -- Process for generating the clock
    i_Clk_t <= not i_Clk_t after ClockPeriod / 2;

    -- Testbench sequence
    Simulation : process is
    begin
        wait until rising_edge(i_Clk_t);
        wait until rising_edge(i_Clk_t);

        -- Take the UUT out of reset
        i_nRst_t <= '1';
        wait;
    end process Simulation;
end sim;