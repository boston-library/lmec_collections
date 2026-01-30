# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MltSearchBuilder do
  let(:search_builder) { described_class.new processor_chain, scope }

  let(:processor_chain) { [] }
  let(:blacklight_config) { Blacklight::Configuration.new }
  let(:scope) { double blacklight_config: blacklight_config, search_state_class: nil }

  describe '#default_processor_chain' do
    it 'returns the correct methods' do
      expect(search_builder.default_processor_chain).not_to include(:institution_limit)
    end
  end
end
