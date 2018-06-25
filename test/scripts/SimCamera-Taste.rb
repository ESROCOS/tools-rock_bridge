require 'orocos'
require 'readline'

include Orocos
Orocos.initialize


Orocos.run 'camera_rock_bridge::camera_rock_bridge_task' => 'camera_rock_bridge',
	'camera_simulator::CameraDriver' => 'camera_orogen' do  
  
  camera_rock_bridge = Orocos.name_service.get 'camera_rock_bridge'
  camera_orogen = Orocos.name_service.get 'camera_orogen'
  
  # Never assume that a component supports being reconnected
  # at runtime, it might not be the case
  #
  # If you have the choice, connect before the component is
  # even configured
  
  camera_rock_bridge.setFrameRequest.connect_to camera_orogen.command
  camera_orogen.observation.connect_to camera_rock_bridge.setCameraReport
  camera_orogen.image.connect_to camera_rock_bridge.setImage
  
  camera_rock_bridge.configure
  camera_orogen.configure
  
  camera_rock_bridge.start
  camera_orogen.start
  
  
  
  Readline::readline("Press ENTER to exit\n")
end
