package com.filmsystem.mapreduce.rating;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

/**
 * 评价次数最多的10部电影分析驱动程序
 * 
 * @author FilmSystem
 */
public class RatingCountDriver {
    
    public static void main(String[] args) throws Exception {
        if (args.length != 2) {
            System.err.println("Usage: RatingCountDriver <input path> <output path>");
            System.exit(-1);
        }
        
        Configuration conf = new Configuration();
        
        Job job = Job.getInstance(conf, "rating count analysis");
        job.setJarByClass(RatingCountDriver.class);
        
        // 设置Mapper和Reducer
        job.setMapperClass(RatingCountMapper.class);
        job.setCombinerClass(RatingCountReducer.class);
        job.setReducerClass(RatingCountReducer.class);
        
        // 设置输出key-value类型
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(IntWritable.class);
        
        // 最终输出key-value类型
        job.setOutputKeyClass(IntWritable.class);
        job.setOutputValueClass(Text.class);
        
        // 设置自定义排序比较器（降序）
        job.setSortComparatorClass(IntWritableDecreasingComparator.class);
        
        // 设置输入输出路径
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        
        // 等待作业完成
        boolean success = job.waitForCompletion(true);
        System.exit(success ? 0 : 1);
    }
    
    /**
     * 运行MapReduce作业的方法，供Spring Boot调用
     */
    public static boolean runJob(String inputPath, String outputPath) throws Exception {
        Configuration conf = new Configuration();
        
        Job job = Job.getInstance(conf, "rating count analysis");
        job.setJarByClass(RatingCountDriver.class);
        
        job.setMapperClass(RatingCountMapper.class);
        job.setCombinerClass(RatingCountReducer.class);
        job.setReducerClass(RatingCountReducer.class);
        
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(IntWritable.class);
        job.setOutputKeyClass(IntWritable.class);
        job.setOutputValueClass(Text.class);
        
        job.setSortComparatorClass(IntWritableDecreasingComparator.class);
        
        FileInputFormat.addInputPath(job, new Path(inputPath));
        FileOutputFormat.setOutputPath(job, new Path(outputPath));
        
        return job.waitForCompletion(true);
    }
}