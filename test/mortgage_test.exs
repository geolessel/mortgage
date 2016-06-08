defmodule MortgageTest do
  use ExUnit.Case, async: true
  doctest Mortgage

  test ".payment when given months, principle, and rate, returns payment" do
    params = %{months: 360, rate: 0.05 / 12, principle: 100_000}
    assert Mortgage.payment(params) == 536.82
  end

  test ".payment when given years, principle, and rate, returns payment" do
    params = %{years: 30, rate: 0.05, principle: 100_000}
    assert Mortgage.payment(params) == 536.82
  end

  test ".term when given principle, rate, and payment, returns months" do
    params = %{principle: 100_000, rate: 0.05 / 12, payment: 536.82}
    assert Mortgage.term(params) == 360.00
  end

  test ".principle when given rate, payment, and months, returns principle" do
    params = %{rate: 0.05 / 12, payment: 536.82, months: 360}
    assert_in_delta 99_999, 100_001, Mortgage.principle(params)
  end

  test ".rate calculates periodic rate" do
    params = %{principle: 100_000, payment: 536.82, months: 360}
    assert_in_delta Mortgage.rate(params) * 12, 0.05, 0.0001
  end
end
