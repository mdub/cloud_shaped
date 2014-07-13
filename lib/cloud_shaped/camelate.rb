module CloudShaped

  module Camelate

    refine Symbol do

      def camelate
        to_s.split('_').map(&:capitalize).join
      end

    end

    refine String do

      def camelate
        self
      end

    end

  end

end
