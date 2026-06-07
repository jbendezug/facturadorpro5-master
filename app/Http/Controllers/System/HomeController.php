<?php

namespace App\Http\Controllers\System;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\System\Client;
use Symfony\Component\Process\Process;
use Symfony\Component\Process\Exception\ProcessFailedException;

class HomeController extends Controller
{
    public function index()
    {
        $clients = Client::get();
        $delete_permission = config('tenant.admin_delete_client');

        $avail = new Process(['df', '-m', '-h', '--output=pcent', '/']);
        $avail->run();
        $discused = $avail->getOutput();
        $disc_used = $discused != "" ? substr($discused, 0, -1) : 0;

        $i_used = '';
        if ($disc_used != 0) {
            $inodes = new Process(['df', '-i', '/']);
            $inodes->run();
            $output = $inodes->getOutput();
            $lines = explode("\n", trim($output));
            if (count($lines) > 1) {
                $parts = preg_split('/\s+/', $lines[1]);
                $i_used = $parts[4] ?? '0';
            }
        }
        $i_used = $i_used != "" ? substr($i_used, 0, -1) : 0;

        $df = new Process(['du', '-sh', storage_path()]);
        $df->run();
        $storage_size = $df->getOutput();
        $storage_size = $storage_size != "" ? substr($storage_size, 0, -1) : 0;

        $id = new Process(['git', 'describe', '--tags']);
        $id->run();
        $version = $id->getOutput();
        // $tag = new Process('git tag | sort -V | tail -1');
        // $tag->run();
        // $res_tag = $tag->getOutput();
        // $version = $res_tag.' - '.$res_id;

        return view('system.dashboard')->with('clients', count($clients))
                ->with('delete_permission', $delete_permission)
                ->with('disc_used', $disc_used)
                ->with('i_used', $i_used)
                ->with('storage_size', $storage_size)
                ->with('version', $version);
    }
}
