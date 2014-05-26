require_relative 'helper'
require 'yaml'

module LFDTest

  module Task

    class EnvTest < ::LFDTest::TestCase

      def test_check_flex_sdk_env
        assert lfd.flex_sdk_ready?
        assert lfd.mxmlc_ready?
        assert lfd.compc_ready?
      end

      def test_check_fp_env
        assert lfd.fp_ready?
      end

    end

  end
end
