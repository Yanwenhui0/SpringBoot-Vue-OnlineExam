package com.exam.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.exam.entity.QuestionPackage;

import java.util.List;

/**
 * @author yanwenhui
 * @date 2020/4/5 22:34
 */
public interface QuestionPackageService {

    /**
     *
     * @param questionPackage
     */
    void save(QuestionPackage questionPackage);

    /**
     *
     * @param questionPackage
     */
    void delete(QuestionPackage questionPackage);

    /**
     *
     * @param studentId
     * @return
     */
    IPage<QuestionPackage> getPackage(String studentId, int page, int size);
}
