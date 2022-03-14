from clvm.casts import int_from_bytes
from clvm_tools import binutils

from profit.consensus.block_rewards import calculate_base_farmer_reward, calculate_pool_reward
from profit.types.blockchain_format.program import Program
from profit.types.condition_opcodes import ConditionOpcode
from profit.util.bech32m import decode_puzzle_hash, encode_puzzle_hash
from profit.util.condition_tools import parse_sexp_to_conditions
from profit.util.ints import uint32

address1 = "profit1henj6hjprnmrn2x657m75mhp4afc858ke4vqxn2yfqk4g9gptvmq4dhhn4"  # Profit Crypto Strategic Reserves Wallet Address
address2 = "profit1henj6hjprnmrn2x657m75mhp4afc858ke4vqxn2yfqk4g9gptvmq4dhhn4"  # Profit Crypto Strategic Reserves Wallet Address

ph1 = decode_puzzle_hash(address1)
ph2 = decode_puzzle_hash(address2)

pool_amounts = int(calculate_pool_reward(uint32(0)) / 2)
farmer_amounts = int(calculate_base_farmer_reward(uint32(0)) / 2)

assert pool_amounts * 2 == calculate_pool_reward(uint32(0))
assert farmer_amounts * 2 == calculate_base_farmer_reward(uint32(0))


def make_puzzle(amount: int) -> int:
    puzzle = f"(q . ((51 0x{ph1.hex()} {amount}) (51 0x{ph2.hex()} {amount})))"
    # print(puzzle)

    puzzle_prog = Program.to(binutils.assemble(puzzle))
    print("Program: ", puzzle_prog)
    puzzle_hash = puzzle_prog.get_tree_hash()

    solution = "()"
    prefix = "profit"
    print("PH", puzzle_hash)
    print(f"Address: {encode_puzzle_hash(puzzle_hash, prefix)}")

    result = puzzle_prog.run(solution)
    error, result_human = parse_sexp_to_conditions(result)

    total_profit = 0
    if error:
        print(f"Error: {error}")
    else:
        assert result_human is not None
        for cvp in result_human:
            assert len(cvp.vars) == 2
            total_profit += int_from_bytes(cvp.vars[1])
            print(
                f"{ConditionOpcode(cvp.opcode).name}: {encode_puzzle_hash(cvp.vars[0], prefix)},"
                f" amount: {int_from_bytes(cvp.vars[1])}"
            )
    return total_profit


total_profit = 0
print("Pool address: ")
total_profit += make_puzzle(pool_amounts)
print("\nFarmer address: ")
total_profit += make_puzzle(farmer_amounts)

assert total_profit == calculate_base_farmer_reward(uint32(0)) + calculate_pool_reward(uint32(0))
