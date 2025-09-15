package com.filmsystem.mapreduce.rating;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.WritableComparator;
import org.apache.hadoop.mapreduce.Partitioner;

/**
 * 自定义IntWritable降序比较器
 * 用于按评价次数从高到低排序
 * 
 * @author FilmSystem
 */
public class IntWritableDecreasingComparator extends WritableComparator {
    
    protected IntWritableDecreasingComparator() {
        super(IntWritable.class, true);
    }
    
    @Override
    public int compare(byte[] b1, int s1, int l1, byte[] b2, int s2, int l2) {
        // 反向比较，实现降序
        return -super.compare(b1, s1, l1, b2, s2, l2);
    }
}