describe RunChecker do
  before(:each) do
    @lock_file_path =
      File.expand_path(File.join('..', 'test.lock'),
                       File.dirname(__FILE__))
    @run_checker = RunChecker.new(@lock_file_path)
  end

  after(:each) do
    @run_checker.cleanup
  end

  it { expect(@run_checker.lock).to eq(true) }

  it 'dead process' do
    File.open(@lock_file_path, 'w') do |f|
      f.puts 999_999_999
    end

    expect(@run_checker.lock).to eq(true)
  end
end
