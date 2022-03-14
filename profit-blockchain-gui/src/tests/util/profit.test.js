const profit = require('../../util/profit');

describe('profit', () => {
  it('converts number mojo to profit', () => {
    const result = profit.mojo_to_profit(1000000);

    expect(result).toBe(0.000001);
  });
  it('converts string mojo to profit', () => {
    const result = profit.mojo_to_profit('1000000');

    expect(result).toBe(0.000001);
  });
  it('converts number mojo to profit string', () => {
    const result = profit.mojo_to_profit_string(1000000);

    expect(result).toBe('0.000001');
  });
  it('converts string mojo to profit string', () => {
    const result = profit.mojo_to_profit_string('1000000');

    expect(result).toBe('0.000001');
  });
  it('converts number profit to mojo', () => {
    const result = profit.profit_to_mojo(0.000001);

    expect(result).toBe(1000000);
  });
  it('converts string profit to mojo', () => {
    const result = profit.profit_to_mojo('0.000001');

    expect(result).toBe(1000000);
  });
  it('converts number mojo to colouredcoin', () => {
    const result = profit.mojo_to_colouredcoin(1000000);

    expect(result).toBe(1000);
  });
  it('converts string mojo to colouredcoin', () => {
    const result = profit.mojo_to_colouredcoin('1000000');

    expect(result).toBe(1000);
  });
  it('converts number mojo to colouredcoin string', () => {
    const result = profit.mojo_to_colouredcoin_string(1000000);

    expect(result).toBe('1,000');
  });
  it('converts string mojo to colouredcoin string', () => {
    const result = profit.mojo_to_colouredcoin_string('1000000');

    expect(result).toBe('1,000');
  });
  it('converts number colouredcoin to mojo', () => {
    const result = profit.colouredcoin_to_mojo(1000);

    expect(result).toBe(1000000);
  });
  it('converts string colouredcoin to mojo', () => {
    const result = profit.colouredcoin_to_mojo('1000');

    expect(result).toBe(1000000);
  });
});
