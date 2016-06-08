defmodule Mortgage do
  def payment(%{years: years, rate: r, principle: p}) do
    payment(%{months: years * 12, rate: r / 12, principle: p})
  end
  def payment(%{months: months, rate: rate, principle: principle}) do
    # rP(1+r)^n / (1+r)^n - 1
    num = rate * principle * :math.pow(1 + rate, months)
    den = :math.pow(1 + rate, months) - 1
    (num / den) |> Float.round(2)
  end

  def term(%{principle: principle, rate: rate, payment: payment}) do
    # n = - (LN(1-(P/PMT)*(r/12)))/LN(1+(r/12))
    num = :math.log(1 - (principle / payment) * rate)
    den = :math.log(1 + rate)
    (num / den * -1) |> Float.round(2)
  end

  def principle(%{rate: rate, payment: payment, months: months}) do
    #     A   =        P * i
    #            ------------------
    #              1 - (1 + i)^-n
    principle_times_payment = rate / (1 - :math.pow(1 + rate, months * -1))
    (payment / principle_times_payment) |> Float.round(2)
  end

  def rate(%{principle: principle, payment: payment, months: months}) do
    do_rate(%{min: 0, max: 1, payment: payment, months: months, principle: principle})
  end

  defp do_rate(%{min: min, max: max}) when (max - min < 1.0e-9), do: max
  defp do_rate(params = %{min: min, max: max, payment: actual}) do
    mid = (min + max) / 2
    attempt = payment(put_in(params[:rate], mid))
    cond do
      attempt >  actual -> do_rate(%{params | min: min, max: mid})
      attempt <= actual -> do_rate(%{params | min: mid, max: max})
    end
  end
end
