# ASR distribution packages for Arch Linux

This repository helps to manage distribution packages for speech recognition and text-to-speech. Included:

* ESPnet 2 [![AUR](https://img.shields.io/aur/version/python-espnet-git?style=plastic)](https://aur.archlinux.org/packages/python-espnet-git)
* SpeechBrain [![AUR](https://img.shields.io/aur/version/python-speechbrain-git?style=plastic)](https://aur.archlinux.org/packages/python-speechbrain-git)
* k2 [![AUR](https://img.shields.io/aur/version/python-k2-git?style=plastic)](https://aur.archlinux.org/packages/python-k2-git)

Distribution with: [![Python](https://img.shields.io/archlinux/v/extra/x86_64/python?label=Python&style=plastic)](https://archlinux.org/packages/extra/x86_64/python/)
[![Pytorch](https://img.shields.io/archlinux/v/community/x86_64/python-pytorch?label=Pytorch&style=plastic)](https://archlinux.org/packages/community/x86_64/python-pytorch/)
[![CUDA](https://img.shields.io/archlinux/v/community/x86_64/cuda?label=CUDA&style=plastic)](https://archlinux.org/packages/community/x86_64/cuda/)


Please open an issue if you find that a package is outdated or if a dependency is missing.

# Packages

* `python-ctc-segmentation-git` [![AUR](https://img.shields.io/aur/version/python-ctc-segmentation-git?style=plastic)](https://aur.archlinux.org/packages/python-ctc-segmentation-git)
* `python-espnet-git` [![AUR](https://img.shields.io/aur/version/python-espnet-git?style=plastic)](https://aur.archlinux.org/packages/python-espnet-git)
* `python-g2p-git` [![AUR](https://img.shields.io/aur/version/python-g2p-git?style=plastic)](https://aur.archlinux.org/packages/python-g2p-git)
* `python-kaldiio-git` [![AUR](https://img.shields.io/aur/version/python-kaldiio-git?style=plastic)](https://aur.archlinux.org/packages/python-kaldiio-git)
* `python-wandb-git` [![AUR](https://img.shields.io/aur/version/python-wandb-git?style=plastic)](https://aur.archlinux.org/packages/python-wandb-git)
* `python-pytorch-complex-git` [![AUR](https://img.shields.io/aur/version/python-pytorch-complex-git?style=plastic)](https://aur.archlinux.org/packages/python-pytorch-complex-git)
* `python-pytorch-wpe-git` [![AUR](https://img.shields.io/aur/version/python-pytorch-wpe-git?style=plastic)](https://aur.archlinux.org/packages/python-pytorch-wpe-git)
* `python-sentencepiece-git` [![AUR](https://img.shields.io/aur/version/python-sentencepiece-git?style=plastic)](https://aur.archlinux.org/packages/python-sentencepiece-git)
* `python-espnet-model-zoo-git` [![AUR](https://img.shields.io/aur/version/python-espnet-model-zoo-git?style=plastic)](https://aur.archlinux.org/packages/python-espnet-model-zoo-git)
* `python-espnet-tts-frontend-git` [![AUR](https://img.shields.io/aur/version/python-espnet-tts-frontend-git?style=plastic)](https://aur.archlinux.org/packages/python-espnet-tts-frontend-git)
* `python-k2-git` [![AUR](https://img.shields.io/aur/version/python-k2-git?style=plastic)](https://aur.archlinux.org/packages/python-k2-git)
* `python-normalise-git` [![AUR](https://img.shields.io/aur/version/python-normalise-git?style=plastic)](https://aur.archlinux.org/packages/python-normalise-git)
* `python-dtw-python-git` [![AUR](https://img.shields.io/aur/version/python-dtw-python-git?style=plastic)](https://aur.archlinux.org/packages/python-dtw-python-git)
* `python-hyperpyyaml-git` [![AUR](https://img.shields.io/aur/version/python-hyperpyyaml-git?style=plastic)](https://aur.archlinux.org/packages/python-hyperpyyaml-git)
* `python-huggingface-hub-git` [![AUR](https://img.shields.io/aur/version/python-huggingface-hub-git?style=plastic)](https://aur.archlinux.org/packages/python-huggingface-hub-git)
* `python-speechbrain-git` [![AUR](https://img.shields.io/aur/version/python-speechbrain-git?style=plastic)](https://aur.archlinux.org/packages/python-speechbrain-git)


<!---
Generate this list with `./maintain.sh print`
-->

# Toolkits
### ESPnet 2

Only ESPnet v2 works, but not v1.
ESPnet 2 and necessary dependencies can be installed from the AUR as `python-espnet-git` with your favourite AUR helper. The package can be found here:
https://aur.archlinux.org/packages/python-espnet-git/


<details><summary>Notes on dependencies</summary><div>

Notes on dependencies that can be found in the Arch AUR:

* `python-sentencepiece-git` is *not* `sentencepiece-git`, as this does not provide the python bindings. Conflicting package
* `python-espnet-tts-frontend-git`: This package may change later. It can be configured to already include `python-jaconv`, but is currently not.
* `python-jaconv` is only needed for TTS
* `python-kaldiio-git` is a duplicate of `kaldi_io` in PyPI

</div></details>


### SpeechBrain

Speechbrain and necessary dependencies can be installed from the AUR as `python-speechbrain-git` with your favourite AUR helper. The package can be found here:
https://aur.archlinux.org/packages/python-speechbrain-git/

<details><summary>Notes on dependencies</summary><div>

Notes on dependencies that can be found in the Arch AUR:

* `python-huggingface-hub-git` <https://github.com/huggingface/huggingface_hub> Maybe a shared dependency with espnet in the future

</div></details>

