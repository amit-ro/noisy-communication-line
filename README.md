In this simulation a noisy communication line is examined.
The communication system is supposed to work in a bandwidth of 100Hz using audio signals. However, typical audio systems are not designed to work well in in those low frequencies. Therefore, the data will be modulated to a higher frequency – 1.37KHz.

The code consists of 3 parts:

* Transmitter.
*	Noisy channel medium.
*	Receiver.

Further explanation:
The transmitter works in the following way:
*	Maps the info bits using BPSK mapping.
*	Encodes the data using the chosen Nyquist pulse.
*	Modulates the signal to a higher frequency.

The noisy channel just adds noise to the given data, the intensity of the noise can be tuned by the user.
The receiver works in the following way:
*	Demodulates the signal back to its original frequency.
*	Appling low pass filter to reduce noises from the modulation.
*	Approximate the time the data was sent.
*	Approximates the gain added by the modulation.
*	Decodes the data using the Nyquist pulse.
*	Sampling the data.
*	Maps the BPSK signal back to bits.

This code was one of the assignments in the course applied signal processing.
