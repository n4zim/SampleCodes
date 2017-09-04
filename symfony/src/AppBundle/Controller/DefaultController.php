<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends Controller {

    private function getIP() {
        $client = @$_SERVER['HTTP_CLIENT_IP'];
        if(filter_var($client, FILTER_VALIDATE_IP)) return $client;
        $forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
        if(filter_var($forward, FILTER_VALIDATE_IP)) return $forward;
        return $_SERVER['REMOTE_ADDR'];
    }

    private function getServerVar($name) {
        if(isset($_SERVER[$name])) return $_SERVER[$name];
        return 'N/A';
    }

    /**
     * @Route("/", name="homepage")
     */
    public function indexAction(Request $request) {
        $params = [];

        $params['ip'] = $this->getIP();

        $session = $request->getSession();
        $test = $session->get('test');
        if(!$test) {
            $time = time();
            $session->set('test', $time);
            $test = $time;
        }
        $params['timestamp'] = $test;
        
        $params['version'] = phpversion();
        
        $params['host'] = $this->getServerVar('HTTP_HOST');
        
        $params['name'] = $this->getServerVar('SERVER_NAME');
        
        $params['software'] = $this->getServerVar('SERVER_SOFTWARE');
        
        $params['server'] = $this->getServerVar('SERVER_ADDR').":".$this->getServerVar('SERVER_PORT');
        
        $params['remote'] = $this->getServerVar('REMOTE_ADDR').":".$this->getServerVar('REMOTE_PORT');
        
        $params['user'] = $this->getServerVar('USER');
        
        $params['script'] = $this->getServerVar('SCRIPT_FILENAME');
        
        $params['time'] = $this->getServerVar('REQUEST_TIME_FLOAT');

        return $this->render('default/index.html.twig', $params);
    }

}
