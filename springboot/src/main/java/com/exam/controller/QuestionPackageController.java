package com.exam.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.exam.entity.ApiResult;
import com.exam.entity.QuestionPackage;
import com.exam.service.QuestionPackageService;
import com.exam.util.ApiResultHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author yanwenhui
 * @date 2020/4/5 22:36
 */
@RestController
@Validated
@RequestMapping("/package")
public class QuestionPackageController {

    private static Logger LOGGER = LoggerFactory.getLogger(QuestionPackageController.class);

    @Autowired
    private QuestionPackageService questionPackageService;

    @PostMapping(value = {"", "/"})
    public ApiResult savePackage(@RequestBody QuestionPackage questionPackage) {
        questionPackageService.save(questionPackage);
        return ApiResultHandler.buildApiResult(200, "save question to package.", null);
    }

    @DeleteMapping(value = {"", "/"})
    public ApiResult deletePackage(@RequestBody QuestionPackage questionPackage) {
        questionPackageService.delete(questionPackage);
        return ApiResultHandler.buildApiResult(200, "save question to package.", null);
    }

    @GetMapping(value = "/{student}/{page}/{size}")
    public ApiResult getPackage(@PathVariable("student") String student,
                                @PathVariable("page") Integer page,
                                @PathVariable("size") Integer size) {
        IPage<QuestionPackage> packageList = questionPackageService.getPackage(student, page, size);
        return ApiResultHandler.buildApiResult(200, "save question to package.", packageList);
    }
}
