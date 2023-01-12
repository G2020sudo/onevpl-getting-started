# onevpl-getting-started
This is a getting started guide for building the entire stack needed for OneVPL as described at https://github.com/oneapi-src/oneVPL-intel-gpu/releases/tag/intel-onevpl-22.5.4

## Docker Build 

./build-docker.sh

## Docker Run 
1. Create a dir sample-media and copy all HEVC/AVC bitstreams into it.  To create an HEVC bitstream from an MP4 reference the following ffmpeg -y -i /sample-media/my-awesome-video.mp4 -c:v copy -bsf hevc_mp4toannexb -f hevc sample-media/test.hevc
2. ./run-docker.sh
3. At this point you will be inside the Docker container. To decode an HEVC bitstream execute: ./_vplinstall/bin/sample_decode h265 -i /sample-media/test.hevc. Other examples can be found from the source at https://github.com/oneapi-src/oneVPL/tree/master/tools/legacy/sample_decode

Host - OneVPL with the OneVPL GPU Runtime (https://github.com/oneapi-src/oneVPL-intel-gpu/releases/tag/intel-onevpl-22.5.4)
1. TBD - reference the Dockerfile file for an equivalent host install.

### Monitoring GPU usage
From a terminal execute sudo intel_gpu_top. The install the utility execute apt install -y intel-gpu-tools
