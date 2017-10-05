require 'test_helper'

class AssetManagerWorkerTest < ActiveSupport::TestCase
  setup do
    @file = Tempfile.new('asset')
    @legacy_url_path = 'legacy-url-path'
    @worker = AssetManagerWorker.new
  end

  test 'creates a whitehall asset using a file object at the correct path' do
    Services.asset_manager.expects(:create_whitehall_asset).with do |args|
      args[:file].path == @file.path
    end

    @worker.perform(@file.path, @legacy_url_path)
  end

  test 'creates a whitehall asset using the legacy_url_path passed to the worker' do
    Services.asset_manager.expects(:create_whitehall_asset).with(has_entry(legacy_url_path: @legacy_url_path))

    @worker.perform(@file.path, @legacy_url_path)
  end
end
