<?php
/**
 * This file is part of the Mothership GmbH code.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
require_once __DIR__ . "/../vendor/autoload.php";
require_once __DIR__ . "/Local.php";

use \Symfony\Component\Yaml\Yaml;

$sourcePath = pathinfo($argv[1]);


$configuration = Yaml::parse(file_get_contents($argv[1]));
$stateMachine = new Local($configuration);
$stateMachine->renderGraph($sourcePath['dirname'] . '/out/' . $sourcePath['filename'] . '.puml');


