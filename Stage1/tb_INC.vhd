library ieee;
use ieee.std_logic_1164.all;

library work;

entity tb_INC is
end tb_INC;

architecture test of tb_INC is

  component incrementerBlock is
    generic ( N : integer );
    port (  in1 : in std_logic_vector (N-1 downto 0);

         res : out std_logic_vector (N-1 downto 0));
   end component;

  signal in1, res : std_logic_vector(31 downto 0);

  begin

    uut: incrementerBlock generic map ( N => 32 )
      port map (in1, res);

    process

      begin

        wait for 200 ns;
        in1 <= "00000000000000000000001000000000";

        wait for 200 ns;
        in1 <= "00000000000000000100000000000000";

        wait for 200 ns;
        in1 <= "00000000000000000000000000100000";

        wait for 200 ns;
        in1 <= "00000000000000000000011100000000";

        wait for 200 ns;
        in1 <= "00000000000001111000000000000000";

        wait for 200 ns;
        in1 <= "00001110000000000000000011000000";

        end process;
end test;

