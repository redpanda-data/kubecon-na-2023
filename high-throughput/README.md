These are the files used to create the testing of local attached disks on AKS & GKE for comparison.

The results of the "fio" test on the mounted local storage:
#### GKE
```
Jobs: 4 (f=4): [W(4)][100.0%][w=393MiB/s][w=25.1k IOPS][eta 00m:00s]
file1: (groupid=0, jobs=4): err= 0: pid=40: Tue Sep 19 13:58:32 2023
  write: IOPS=21.6k, BW=337MiB/s (354MB/s)(98.8GiB/300001msec); 0 zone resets
    slat (usec): min=2, max=3437, avg=18.17, stdev=38.55
    clat (usec): min=89, max=11945, avg=2780.25, stdev=1051.07
     lat (usec): min=98, max=11955, avg=2798.43, stdev=1055.77
    clat percentiles (usec):
     |  1.00th=[  594],  5.00th=[  676], 10.00th=[  873], 20.00th=[ 1942],
     | 30.00th=[ 2311], 40.00th=[ 2900], 50.00th=[ 3064], 60.00th=[ 3195],
     | 70.00th=[ 3359], 80.00th=[ 3556], 90.00th=[ 3916], 95.00th=[ 4080],
     | 99.00th=[ 5014], 99.50th=[ 5080], 99.90th=[ 6063], 99.95th=[ 6587],
     | 99.99th=[ 7373]
   bw (  KiB/s): min=273600, max=486400, per=100.00%, avg=345488.51, stdev=14947.62, samples=2396
   iops        : min=17100, max=30400, avg=21593.03, stdev=934.23, samples=2396
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.05%, 750=8.19%, 1000=2.49%
  lat (msec)   : 2=10.71%, 4=70.83%, 10=7.72%, 20=0.01%
  fsync/fdatasync/sync_file_range:
    sync (usec): min=118, max=108947, avg=2945.61, stdev=1104.22
    sync percentiles (usec):
     |  1.00th=[  619],  5.00th=[  709], 10.00th=[  955], 20.00th=[ 2024],
     | 30.00th=[ 2638], 40.00th=[ 2999], 50.00th=[ 3195], 60.00th=[ 3392],
     | 70.00th=[ 3589], 80.00th=[ 3785], 90.00th=[ 4047], 95.00th=[ 4293],
     | 99.00th=[ 5080], 99.50th=[ 5407], 99.90th=[ 6194], 99.95th=[ 6980],
     | 99.99th=[ 7963]
  cpu          : usr=1.96%, sys=13.31%, ctx=20912643, majf=0, minf=54
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=200.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,6476502,0,0 short=6476446,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
  WRITE: bw=337MiB/s (354MB/s), 337MiB/s-337MiB/s (354MB/s-354MB/s), io=98.8GiB (106GB), run=300001-300001msec

Disk stats (read/write):
    dm-0: ios=0/13565175, merge=0/0, ticks=0/1870124, in_queue=1870124, util=100.00%, aggrios=0/10023289, aggrmerge=0/5, aggrticks=0/1016096, aggrin_queue=1374159, aggrutil=99.99%
  nvme0n1: ios=0/13570120, merge=0/11, ticks=0/1862473, in_queue=2421062, util=99.99%
  nvme0n2: ios=0/6476458, merge=0/0, ticks=0/169719, in_queue=327257, util=99.99%
```
#### AKS
```
Jobs: 4 (f=4): [W(4)][100.0%][w=1768MiB/s][w=113k IOPS][eta 00m:00s]
file1: (groupid=0, jobs=4): err= 0: pid=41677: Thu Sep 28 12:30:02 2023
  write: IOPS=109k, BW=1698MiB/s (1780MB/s)(497GiB/300001msec); 0 zone resets
    slat (usec): min=2, max=6296, avg= 5.68, stdev=12.17
    clat (nsec): min=661, max=12642k, avg=577786.82, stdev=205923.90
     lat (usec): min=27, max=12700, avg=583.58, stdev=208.77
    clat percentiles (usec):
     |  1.00th=[  359],  5.00th=[  375], 10.00th=[  383], 20.00th=[  429],
     | 30.00th=[  486], 40.00th=[  506], 50.00th=[  529], 60.00th=[  570],
     | 70.00th=[  619], 80.00th=[  660], 90.00th=[  799], 95.00th=[ 1012],
     | 99.00th=[ 1254], 99.50th=[ 1352], 99.90th=[ 1680], 99.95th=[ 2089],
     | 99.99th=[ 4686]
   bw (  MiB/s): min=  894, max= 2435, per=100.00%, avg=1698.42, stdev=87.37, samples=2396
   iops        : min=57222, max=155862, avg=108698.84, stdev=5591.45, samples=2396
  lat (nsec)   : 750=0.01%
  lat (usec)   : 20=0.01%, 50=0.01%, 100=0.01%, 250=0.13%, 500=35.64%
  lat (usec)   : 750=52.30%, 1000=6.60%
  lat (msec)   : 2=5.26%, 4=0.04%, 10=0.01%, 20=0.01%
  fsync/fdatasync/sync_file_range:
    sync (nsec): min=29, max=681917, avg=60.18, stdev=464.03
    sync percentiles (nsec):
     |  1.00th=[   29],  5.00th=[   30], 10.00th=[   30], 20.00th=[   30],
     | 30.00th=[   30], 40.00th=[   30], 50.00th=[   30], 60.00th=[   31],
     | 70.00th=[   40], 80.00th=[   50], 90.00th=[   70], 95.00th=[   91],
     | 99.00th=[  161], 99.50th=[  231], 99.90th=[ 5152], 99.95th=[ 5536],
     | 99.99th=[11840]
  cpu          : usr=4.30%, sys=16.20%, ctx=28383908, majf=0, minf=69
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=200.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,32598034,0,0 short=32597974,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
  WRITE: bw=1698MiB/s (1780MB/s), 1698MiB/s-1698MiB/s (1780MB/s-1780MB/s), io=497GiB (534GB), run=300001-300001msec

Disk stats (read/write):
    dm-0: ios=0/33112451, merge=0/0, ticks=0/15883776, in_queue=15883776, util=100.00%, aggrios=0/33124235, aggrmerge=0/52, aggrticks=0/15915470, aggrin_queue=15915469, aggrutil=99.99%
  nvme0n1: ios=0/33124235, merge=0/52, ticks=0/15915470, in_queue=15915469, util=99.99%
```
