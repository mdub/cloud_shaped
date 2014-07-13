module CloudShaped

  module Camelate

    def camelate(arg)
      case arg
      when Symbol
        camelate_symbol(arg)
      else
        arg
      end
    end

    private

    def camelate_symbol(symbol)
      symbol.to_s.split('_').map(&:capitalize).join
    end

  end

end
