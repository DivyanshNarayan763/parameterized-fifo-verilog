library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity parameterized_fifo is
    generic(
        DATA_WIDTH : integer := 8;
        DEPTH : integer := 16
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;
        rd_en : in std_logic;
        din : in std_logic_vector(DATA_WIDTH-1 downto 0);
        dout : out std_logic_vector(DATA_WIDTH-1 downto 0);
        full : out std_logic;
        empty : out std_logic
    );
end entity;

architecture archi of parameterized_fifo is

    function clog2(n : positive) return natural is
        variable result : natural := 0;
        variable value : natural := 1;
    begin
        while value < n loop
            value := value * 2;
            result := result + 1;
        end loop;
        return result;
    end function;

    constant ADDRESS_WIDTH : natural := clog2(DEPTH);

    type mem_t is array (0 to DEPTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);

    signal mem : mem_t;
    signal wr_ptr : unsigned(ADDRESS_WIDTH-1 downto 0);
    signal rd_ptr : unsigned(ADDRESS_WIDTH-1 downto 0);
    signal count : unsigned(ADDRESS_WIDTH downto 0);
	signal dout_reg : std_logic_vector(DATA_WIDTH-1 downto 0);

    signal wr_success : std_logic;
    signal rd_success : std_logic;

begin

    full <= '1' when count = to_unsigned(DEPTH,count'length) else '0';
    empty <= '1' when count = 0 else '0';

    wr_success <= wr_en and not full;
    rd_success <= rd_en and not empty;
    dout <= dout_reg;

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                wr_ptr <= (others => '0');
                rd_ptr <= (others => '0');
                count <= (others => '0');
                dout_reg <= (others => '0');
            else

                if wr_success = '1' then
                    mem(to_integer(wr_ptr)) <= din;

                    if wr_ptr = to_unsigned(DEPTH-1,wr_ptr'length) then
                        wr_ptr <= (others => '0');
                    else
                        wr_ptr <= wr_ptr + 1;
                    end if;
                end if;

                if rd_success = '1' then
                    dout_reg <= mem(to_integer(rd_ptr));

                    if rd_ptr = to_unsigned(DEPTH-1,rd_ptr'length) then
                        rd_ptr <= (others => '0');
                    else
                        rd_ptr <= rd_ptr + 1;
                    end if;
                end if;

                case (wr_success & rd_success) is
                    when "10" =>
                        count <= count + 1;
                    when "01" =>
                        count <= count - 1;
                    when others =>
                        null;
                end case;

            end if;
        end if;
    end process;

end architecture;