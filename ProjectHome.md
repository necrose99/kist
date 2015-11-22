Some ebuilds that are not available in any of other overlays.<br>
About layman: <a href='http://www.gentoo.org/proj/en/overlays/userguide.xml'>here</a><br>
How to add kist overlay:<br>
<br>
1. Edit (as root, of course) /etc/layman/layman.cfg.<br>
There is line, as this:<br>
<pre><code><br>
overlays  : http://www.gentoo.org/proj/en/overlays/repositories.xml<br>
</code></pre>

Add following line below:<br>
<pre><code><br>
http://kist.googlecode.com/svn/trunk/layman-kist.xml<br>
</code></pre>

2. Type:<br>
<pre><code><br>
# layman -L | grep kist<br>
</code></pre>
There should be line similar to this:<br>
<pre><code><br>
* kist-overlay              [Subversion] (http://kist.googlecode.com...)<br>
</code></pre>

3. Add my overlay:<br>
<pre><code><br>
# layman -a kist-overlay<br>
</code></pre>

Some lines blah blah blah... And this's it. You can update your eix:<br>
<pre><code><br>
# eix-update<br>
</code></pre>

Now, you can install any package you want, ie google-chrome<br>
<pre><code><br>
# emerge -av google-chrome-bin<br>
<br>
These are the packages that would be merged, in order:<br>
<br>
Calculating dependencies... done!<br>
[ebuild   R   ] www-client/google-chrome-bin-9999  0 kB [1]<br>
<br>
Total: 1 package (1 reinstall), Size of downloads: 0 kB<br>
Portage tree and overlays:<br>
[0] /usr/portage<br>
[1] /var/lib/layman/kist-overlay<br>
<br>
Would you like to merge these packages? [Yes/No]<br>
</code></pre>

Thanks for using my repo ^^<br>
<br>
If any ebuild doesn't work properly, just tell me, I'll do what I can to fix it. Contact:<br>
Email: garrappachc@gmail.com<br>
Jabber: garrappachc@googlemail.com