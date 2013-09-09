<div id="theme_install_error">
  <p style="
    z-index: 1100;
    position: fixed;
    top: 50%;
    left: 50%;
    width: 600px;
    height: 400px;
    margin: -250px 0 0 -330px;
    padding: 30px;
    line-height: 20px;
    color: #000;
    font-size: 14px;
    background: #fff;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
    -moz-box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
    -o-box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
  "><strong style="display: block; text-align: center; margin-bottom: 15px; font-size: 18px; color: red;">Warning!</strong>
    You see this message because Shoppica 2 is not properly installed/configured. This happens usually due one (or more) of the following reasons:<br /><br />
    1. You have not installed the Shoppica 2 module. Please, go to admin panel, enter Extensions -> Modules, find 'Shoppica 2 CP' and click 'install'.
    <br />
    <br />
    2. You have not properly updated your index.php file. It should contain these two lines (near the end):
    <br />
    <br />
    <span style="display: block; white-space: nowrap; overflow-x: scroll; padding: 6px 7px 5px 7px; font-size: 12px; font-family: Courier New; color: green; border: 1px solid #ddd; width: 99%; resize: none;">
// TB<br />
$controller->dispatch(new Action('common/tb', array('front' => $controller)), new Action('error/not_found'));
    </span>
    <br />
    3. You have not replaced the opencart core files (<em>system/engine/controller.php</em> and <em>catalog/model/setting/extension.php</em>) with these provided with the Shoppica package.
    <br />
    <br />
    <span style="display: block; line-height: 14px; font-size: 11px;color: #666;">For more information about the theme installation, please read carefully the <a style="color: blue;" href="http://shoppica2.com/docs/index.html">Shoppica Documentation</a>.
    <br />
    <br />
    If you think you've made everything according to the installation instructions and this message continues to appear, please contact the support.</span>
  </p>
  <span id="install_error_overlay" style="z-index: 1000; position: fixed; display: block; width: 100%; height: 100%; background: #fff;"></span>
</div>
<?php exit; ?>
