require 'spec_helper'
require_relative '../../lib/string_utils'

RSpec.describe StringUtils do
  it 'slugifies text' do
    expect(StringUtils.slugify(' Hello, World! ')).to eq('hello-world')
  end
end
