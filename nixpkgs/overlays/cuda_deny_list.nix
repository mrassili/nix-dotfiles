self: super: {
  opencv4 = super.opencv4.override{enableUnfree=false; enableCuda=false;};
  # opencv4 = super.opencv4.overrideAttrs(old: {
  #   enableUnfree = false;
  #   enableCuda = false;
  # });
  blender = super.blender.override{cudaSupport=false;};
}
