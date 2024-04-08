{ ... }:

{

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
  
  	enable = true;
  	jack.enable = true;
  	pulse.enable = true;
  	alsa.enable = true;
  	alsa.support32Bit = true;
    lowLatency.enable = true;
  };
	
}
