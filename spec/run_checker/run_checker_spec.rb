describe RunChecker do
  before(:each) do
    @lock_file_path =
      File.expand_path(File.join('..', 'test.lock'),
                       File.dirname(__FILE__))
    @run_checker = RunChecker.new(@lock_file_path)
  end

  after(:each) do
    File.delete(@lock_file_path) if File.exist?(@lock_file_path)
  end

  it { expect(@run_checker.lock).to eq(true) }

  it do
    File.open(@lock_file_path, 'w') do |f|
      f.puts 1
    end

    expect(@run_checker.lock).to eq(false)
  end

  it 'dead process' do
    File.open(@lock_file_path, 'w') do |f|
      f.puts 999_999_999
    end

    expect(@run_checker.lock).to eq(true)
  end

  it do
    File.open(@lock_file_path, 'w') do |f|
      f.puts $PROCESS_ID
    end

    @run_checker.cleanup

    expect(File.exist?(@lock_file_path)).to eq(false)
  end

  it do
    File.open(@lock_file_path, 'w') do |f|
      f.puts 999_999_999
    end

    @run_checker.cleanup

    expect(File.exist?(@lock_file_path)).to eq(true)
  end
end
