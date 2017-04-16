defmodule Elmchemy.Glue do

  defmacro defcurryp(definition, opts \\ [], do: body) do
    {fun, args} = Macro.decompose_call(definition)
    quote do
      defp unquote(fun)() do
        unquote(curry(args, body))
      end
      defp unquote(fun)(unquote_splicing(args)) do
        unquote(body)
      end
    end

  end

  defmacro defcurry(definition, opts \\ [], do: body) do
    {fun, args} = Macro.decompose_call(definition)
    quote do
      def unquote(fun)() do
        unquote(curry(args, body))
      end
      def unquote(fun)(unquote_splicing(args)) do
        unquote(body)
      end
    end
  end

  defp curry([h | args], body) do
    quote do fn unquote(h) -> unquote(curry(args, body)) end end
  end
  defp curry([], body), do: body


end