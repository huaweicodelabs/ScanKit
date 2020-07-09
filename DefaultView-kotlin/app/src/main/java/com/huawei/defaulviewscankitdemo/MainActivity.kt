/*
* Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

* Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
*/


package com.huawei.defaulviewscankitdemo

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.text.TextUtils
import android.widget.Toast
import com.huawei.hms.hmsscankit.ScanUtil
import com.huawei.hms.ml.scan.HmsScan
import com.huawei.hms.ml.scan.HmsScanAnalyzerOptions
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    companion object
    {
        private val DEFINED_CODE = 222
        private val REQUEST_CODE_SCAN = 0X01
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        default_view?.setOnClickListener({ v -> newViewBtnClick() })
    }

    private fun newViewBtnClick() {
        // Initialize a list of required permissions to request runtime
        val list = arrayOf(Manifest.permission.CAMERA, Manifest.permission.READ_EXTERNAL_STORAGE)
        ActivityCompat.requestPermissions(this, list, DEFINED_CODE)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (grantResults.size < 2 || grantResults[0] != PackageManager.PERMISSION_GRANTED || grantResults[1] != PackageManager.PERMISSION_GRANTED) return
        else if (requestCode == DEFINED_CODE) {
            // Call the barcode scanning view in Default View mode.
            ScanUtil.startScan(this, REQUEST_CODE_SCAN, HmsScanAnalyzerOptions.Creator().setHmsScanTypes(HmsScan.ALL_SCAN_TYPE).create())
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        //receive result after your activity finished scanning
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode != Activity.RESULT_OK || data == null) { return }
        // Obtain the return value of HmsScan from the value returned by the onActivityResult method by using ScanUtil.RESULT as the key value.
        else if (requestCode == REQUEST_CODE_SCAN) {
            when (val obj: Any = data.getParcelableExtra(ScanUtil.RESULT)) {
                is HmsScan -> {
                    if (!TextUtils.isEmpty(obj.getOriginalValue())) {
                        Toast.makeText(this, obj.getOriginalValue(), Toast.LENGTH_SHORT).show()
                    }
                    return
                }
            }
        }
    }


}
