package com.exam.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.entity.PaperManage;
import com.exam.mapper.PaperMapper;
import com.exam.service.PaperService;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class PaperServiceImpl implements PaperService {

    @Autowired
    private PaperMapper paperMapper;
    @Override
    public List<PaperManage> findAll() {
        return paperMapper.findAll();
    }

    @Override
    public List<PaperManage> findById(Integer paperId) {
        return paperMapper.findById(paperId);
    }

    @Override
    public int add(PaperManage paperManage) {
        return paperMapper.add(paperManage);
    }

    @Override
    public void remove(PaperManage paperManage) {
        paperMapper.delete(new QueryWrapper<>(paperManage));
    }

    @Override
    public String countType(Integer paperId) {
        PaperManage paperManage = new PaperManage();
        paperManage.setPaperId(Integer.valueOf(paperId));
        List<PaperManage> paperManages = paperMapper.selectList(new QueryWrapper<>(paperManage));
        Map<String, Integer> data = Maps.newHashMap();
        data.put("total", 0);
        data.put("multiQuestion", 0);
        data.put("fillQuestion", 0);
        data.put("judgeQuestion", 0);

        for (PaperManage manage : paperManages) {
            if(manage.getQuestionType() == 1) {
                data.put("multiQuestion", data.get("multiQuestion") + 1);
            } else if (manage.getQuestionType() == 2) {
                data.put("fillQuestion", data.get("fillQuestion") + 1);
            } else {
                data.put("judgeQuestion", data.get("judgeQuestion") + 1);
            }
            data.put("total", data.get("total") + 1);
        }

        String count = data.get("total") + "  (选择题：" + data.get("multiQuestion") + "，填空题：" + data.get("fillQuestion") + "，判断题：" + data.get("judgeQuestion") + " )";
        return count;
    }

}
