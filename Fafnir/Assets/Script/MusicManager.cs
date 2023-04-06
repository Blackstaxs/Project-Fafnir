using UnityEngine;
using UnityEngine.Audio;

public class MusicManager : MonoBehaviour
{
    public AudioSource audioSource;
    public AudioClip BotS;
    public AudioClip BossS;
    public AudioClip LevelS;

    private void Start()
    {

    }

    private void Update()
    {

    }

    private void PlayNextTrack()
    {
        /*
        if (musicTracks.Length == 0) return;

        audioSource.clip = musicTracks[currentTrackIndex];
        audioSource.Play();

        currentTrackIndex = (currentTrackIndex + 1) % musicTracks.Length;
        */
    }

    public void PlayFirstTrackOnLoop()
    {
        /*
        if (musicTracks.Length == 0) return;

        audioSource.clip = musicTracks[0];
        audioSource.loop = true;
        audioSource.Play();
        */
        audioSource.PlayOneShot(BotS);
    }

    public void PlayBossTrackOnLoop()
    {
        /*
        if (musicTracks.Length == 0) return;

        audioSource.clip = musicTracks[musicTracks.Length - 1];
        audioSource.loop = true;
        audioSource.Play();
        */
        audioSource.PlayOneShot(BossS);
    }

    public void PlayRandomTrack()
    {
        /*
        if (musicTracks.Length <= 2) return;

        int randomTrackIndex;

        do
        {
            randomTrackIndex = Random.Range(1, musicTracks.Length - 1);
        } while (randomTrackIndex == currentTrackIndex);

        currentTrackIndex = randomTrackIndex;
        audioSource.clip = musicTracks[currentTrackIndex];
        audioSource.Play();
        */
        audioSource.PlayOneShot(LevelS);
    }
}
