package com.gamedis.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gamedis.service.UploadService;

import common.util.DataMap;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
public class UploadController {
	
		@Autowired
		private UploadService uploadService;
	
		@GetMapping("/upload/uploadForm")
		public void uploadForm() {
			
		}
	
		@RequestMapping("/upload/uploadList")
		@ResponseBody
		public List<DataMap> getUploadList(HttpServletRequest request){
			
			List<DataMap> list = uploadService.getUploadList(request.getParameter("pcode"));
			
			return list;
		}
		
		
		@PostMapping("/uploadFormAction")
		public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
			
			String uploadFolder = "C:\\upload";
			
			for(MultipartFile multipartFile :  uploadFile) {
				
				System.out.println("----------------------------------------");
				System.out.println("Upload File Name: "+ multipartFile.getOriginalFilename());
				System.out.println("Upload File Size: "+ multipartFile.getSize());
				
				File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
				
				try {
					multipartFile.transferTo(saveFile);
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}	
			}
		}
	
		@GetMapping("/upload/uploadAjax")
		public void uploadAjax(Model model) {
			System.out.println("uploadAjax");
			List<DataMap> list = uploadService.getProductList();
			System.out.println(list);
			model.addAttribute("productList", list);
		}
		
		@PostMapping("/uploadAjaxAction")
		@ResponseBody
		public ResponseEntity<List<DataMap>> uploadAjaxPost(MultipartFile[] uploadFile, HttpServletRequest request) {
			
			System.out.println("upload ajax post....");
			
			List<DataMap> list= new ArrayList<DataMap>();
			
			String uploadFolder = "C:\\upload";
			String uploadFolderPath = getFolder();
			// make folder.....
			File uploadPath = new File(uploadFolder, uploadFolderPath);
			
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
			// make yyyy/MM/dd folder
			
			for (MultipartFile multipartFile: uploadFile) {
				
				DataMap uploadFile1= new DataMap();
				
				System.out.println("----------------------------------------");
				System.out.println("Upload File Name: "+ multipartFile.getOriginalFilename());
				System.out.println("Upload File Size: "+ multipartFile.getSize());
				
				String uploadFileName = multipartFile.getOriginalFilename();
				// IE has file path
				uploadFileName= uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
				System.out.println("only file name: "+uploadFileName);
				
				uploadFile1.put("uploadFileName", uploadFileName);
				
				UUID uuid= UUID.randomUUID();
				uploadFileName = uuid.toString() + "_" + uploadFileName;
				
				try {
					File saveFile = new File(uploadPath, uploadFileName);
					multipartFile.transferTo(saveFile);

					uploadFile1.put("uuid", uuid.toString());
					uploadFile1.put("uploadPath", uploadFolderPath);
					
					//check image type file
					if(checkImageType(saveFile)) {
						
						uploadFile1.put("fileType", "I");
						uploadFile1.put("image", true);
						FileOutputStream thumbnail= new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
						Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100 , 100);
						thumbnail.close();
					}else {
						uploadFile1.put("fileType", "D");
					}
					
					//check screenType
					if(request.getParameter("screenType").equals("M")) {
						
						System.out.println("screenType: M");
						uploadFile1.put("screenType", "M");
						
					}else if(request.getParameter("screenType").equals("S")) {
						
						System.out.println("screenType: S");
						uploadFile1.put("screenType", "S");
						
					}else if(request.getParameter("screenType").equals("L")){
						
						System.out.println("screenType: L");
						uploadFile1.put("screenType", "L");
						
					}
					
					// to pcode
					uploadFile1.put("pcode", request.getParameter("pcode"));
					
//					System.out.println("include:" + request.getParameter("includeId"));
					uploadFile1.put("includeId", request.getParameter("includeId"));
					// add to list
					list.add(uploadFile1);
					
					//mapper insert
					System.out.println( "uploadfile1: " + uploadFile1.getMap());
					uploadService.insertUploadFile(uploadFile1);
					
					
				} catch(Exception e) {
					System.out.println(e.getMessage());
					System.out.println("nullpointException..");
				}	
			} //end for
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		
		
		private String getFolder() {
			SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
			Date date= new Date();
			String str = sdf.format(date);
			return str.replace("-", File.separator);
		}
		
		private boolean checkImageType(File file) {
			
			try {
				String contentType= Files.probeContentType(file.toPath());
				return contentType.startsWith("image");
			} catch(Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		
		
		@GetMapping("/display")
		@ResponseBody
		public ResponseEntity<byte[]> getFile(String fileName){
			
			System.out.println("fileName : "+ fileName);
			File file = new File("c:\\upload\\" + fileName);
			
			ResponseEntity<byte[]> result = null;
			
			try {
				HttpHeaders header= new HttpHeaders();
				
				header.add("Content-Type", Files.probeContentType(file.toPath()));
				result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			return result;
		}
		
		@GetMapping("/download")
		@ResponseBody
		public ResponseEntity<Resource> downloadFile(@RequestHeader("User-agent") String userAgent, String fileName){
			
			System.out.println("download file : "+ fileName);		
			Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
			
			if(resource.exists()== false) {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}

			String resourceName = resource.getFilename();
			
			//remove UUID
			String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
			
			
			HttpHeaders headers = new HttpHeaders();
			try {
				
				String downloadName = null;
				
				if(userAgent.contains("Trident")) {
					
					System.out.println("IE browser");
					downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
					
				}else if(userAgent.contains("Edge")) {
					
					System.out.println("Edge browser");
					downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
					System.out.println("Edge name: "+ downloadName);
				
				}else {
					System.out.println("chrome browser");
					downloadName = new String(new String(resourceOriginalName.getBytes("UTF-8"),
						"ISO-8859-1"));
				}
				
				headers.add("Content-Disposition", "attachment; fileName="+ downloadName);
				
			}catch(UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		}
		
		@PostMapping("/deleteFile")
		@ResponseBody
		public ResponseEntity<String> deleteFile(String fileName, String type){
			
			File file;
			
			try {
				
				file = new File("C:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
				String documentFileName = file.toString();
				
				file.delete();
				
				String splitDocUuid[]= splitMethod(documentFileName);
				
				//docData delete 
				uploadService.deleteUploadFile(splitDocUuid[0]);

				if( type.equals("image")) {
					
					String largeFileName = file.getAbsolutePath().replace("s_", "");
					
					System.out.println("largeFileName : " + largeFileName);
					
					file = new File(largeFileName);
					
					file.delete();
					
					String splitImgUuid[] = splitMethod(largeFileName);
				
					//imageData delete 	
					uploadService.deleteUploadFile(splitImgUuid[0]);
				};
				
			} catch( UnsupportedEncodingException e) {
				e.printStackTrace();
				return new  ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			return new ResponseEntity<String> ("deleted", HttpStatus.OK);
		}
		
		
	public String[] splitMethod(String splitParam) {
		
		String splitFiles[] = splitParam.split("\\\\");
		String splitName = splitFiles[splitFiles.length-1];
		String splitNames[] = splitName.split("_");
		
		return splitNames;
//		return null;
	}
	
	@RequestMapping("/upload/getUploadIncludeProduct")
	@ResponseBody
	public List<DataMap> getUploadIncludeProduct(HttpServletRequest request){
		System.out.println("uploadinclude get!");
		
		List<DataMap> result = uploadService.getUploadIncludeProduct(request.getParameter("pcode"));
		
		return result;
	}
}
