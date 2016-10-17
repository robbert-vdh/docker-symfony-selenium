This image is meant for acceptance testing using Continuous Integration and contains everything from [themecloud/symfony](https://hub.docker.com/r/themecloud/symfony/). In addition, this image also contains:
- Selenium WebDriver
- Firefox
- Chrome
- PhantomJS

## NOTE:
Using Chrome might lead to memory issues, as Chrome is very dependent on shared memory. See https://bugs.chromium.org/p/chromium/issues/detail?id=519952. To prevent this you must either mount this image with access to the hosts shared memory (`-v /dev/shm:/dev/shm`) or with extended privileges (`--privileged`, not recommanded).
