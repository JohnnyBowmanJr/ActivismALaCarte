require 'spec_helper'

describe Campaign do
  it { should have_many(:calls) }
  it { should have_many(:users).through(:calls)}
  it { should belong_to(:organizer)}

end
