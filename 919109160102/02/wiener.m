%Read image
I = im2double(imread('./02/cameraman.tif'));
figure,subplot(2,3,1),imshow(I);
title('Original Image (courtesy of MIT)');

%Simulate a motion blur
LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'conv', 'circular');
subplot(2,3,2),imshow(blurred);
title('Blurred Image');

%Restore the blurred image
wnr1 = deconvwnr(blurred, PSF, 0);
subplot(2,3,3),imshow(wnr1);
title('Restored Image');

%Simulate blur and noise
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', ...
                        noise_mean, noise_var);
subplot(2,3,4),imshow(blurred_noisy)
title('Simulate Blur and Noise')

%Restore the blurred and noisy image:First attempt
wnr2 = deconvwnr(blurred_noisy, PSF, 0);
subplot(2,3,5);imshow(wnr2);title('Restoration of Blurred, Noisy Image Using NSR = 0')

%Restore the Blurred and Noisy Image: Second Attempt
signal_var = var(I(:));
wnr3 = deconvwnr(blurred_noisy, PSF, noise_var / signal_var);
subplot(2,3,6),imshow(wnr3)
title('Restoration of Blurred, Noisy Image Using Estimated NSR');