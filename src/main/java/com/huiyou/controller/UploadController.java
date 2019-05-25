package com.huiyou.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.huiyou.model.DataGridView;

@Controller
@RequestMapping("UploadController")
public class UploadController {

	@RequestMapping("upload")
	@ResponseBody
	public DataGridView upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpSession session) {
		System.out.println("上传开始");
		String savePath = "D:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\SchoolProject\\upload";
		String tempPath = session.getServletContext().getRealPath("/temp");
		File file1 = new File(tempPath);
		if (!file1.exists() && !file1.isDirectory()) {
			System.out.println("文件或目录不存在！");
			file1.mkdir();
		}
		String oldName = file.getOriginalFilename();
		System.out.println(oldName);
		String[] split = oldName.split("\\.");
		System.out.println("split length: " + split.length);
		String newName = System.currentTimeMillis() + "." + split[1];
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		String date = df.format(new Date());
		
		File file2 = new File(savePath + "/" + date);
		if ( !file2.exists() && !file2.isDirectory()) {
			file2.mkdirs();
		}
		File file3 = new File(savePath + "/" + date, newName);
		try {
			file.transferTo(file3);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		List<Object> list = new ArrayList<>();
		list.add("upload/" + date + "/" + newName);
		DataGridView dataGridView = new DataGridView();
		dataGridView.setCode(200);
		dataGridView.setMsg("上传成功！");
		dataGridView.setData(list);
		return dataGridView;
	}
}
