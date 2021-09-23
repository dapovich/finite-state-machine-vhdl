library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity finite_state_machine is
    generic(ClockFrequencyHz: integer);
    port(
        i_Clk  : in std_logic;
        i_nRst : in std_logic   -- Negative reset
    );
end entity;

architecture RTL of finite_state_machine is

    -- Enumerated type declaration and state signal declaration
    type t_State is (FirstState, SecondState, ThirdState,
                     FourthState, FifthState, SixthState,
                     SeventhState, EighthState);
    signal State : t_State;

begin

    process(i_Clk) is
    begin
        if rising_edge(i_Clk) then
            if i_nRst = '0' then
                -- Reset values
                State <= FirstState;
            else
                case State is
                    when FirstState =>
                        State <= SecondState;
                    when SecondState =>
                        State <= ThirdState;
                    when ThirdState =>
                        State <= FourthState;
                    when FourthState =>
                        State <= FifthState;
                    when FifthState =>
                        State <= SixthState;
                    when SixthState =>
                        State <= SeventhState;
                    when SeventhState =>
                        State <= EighthState;
                    when EighthState =>
                        State <= FifthState;
                end case;
            end if;
        end if;
    end process;
end RTL;


